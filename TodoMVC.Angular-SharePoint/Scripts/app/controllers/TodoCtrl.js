/**
 * The main controller for the app. The controller:
 * - retrieves and persists the model via the todoStorage service
 * - exposes the model to the template and provides event handlers
 */
angular.module('todomvc').controller('TodoCtrl', function TodoCtrl($scope, $routeParams, todoStorage, filterFilter, Todo) {
  'use strict';
  var todos = $scope.todos = Todo.query();

  $scope.newTodo = new Todo({
    Title: '',
    Completed: false
  });
  $scope.editedTodo = null;

  $scope.$watch('todos', function (/* newValue, oldValue */) {
    $scope.remainingCount = filterFilter(todos, { Completed: false }).length;
    $scope.completedCount = todos.length - $scope.remainingCount;
    $scope.allChecked = !$scope.remainingCount;
    // if (newValue !== oldValue) { // This prevents unneeded calls to the local storage
    //   angular.forEach(todos, function(todo) {
    //     todo.$save();
    //   });
    // }
  }, true);

  // Monitor the current route for changes and adjust the filter accordingly.
  $scope.$on('$routeChangeSuccess', function () {
    var status = $scope.status = $routeParams.status || '';

    $scope.statusFilter = (status === 'active') ?
      { Completed: false } : (status === 'completed') ?
      { Completed: true } : null;
  });

  $scope.addTodo = function () {
    $scope.newTodo.Title = $scope.newTodo.Title.trim();
    if (!$scope.newTodo.Title.length) {
      return;
    }
    $scope.saveTodo($scope.newTodo).then(function() {
      $scope.todos.push($scope.newTodo);
      $scope.newTodo = new Todo({
        Title: '',
        Completed: false
      });
    }, function(err) {
      console.error(err);
    });
  };

  $scope.editTodo = function (todo) {
    $scope.editedTodo = todo;
    // Clone the original todo to restore it on demand.
    $scope.originalTodo = new Todo(todo);
  };

  $scope.doneEditing = function (todo) {
    if ($scope.editedTodo === null) { return; }
    $scope.editedTodo = null;
    todo.Title = todo.Title.trim();

    if (!todo.Title) {
      $scope.removeTodo(todo);
    } else if (todo.Title !== $scope.originalTodo.Title) {
      $scope.saveTodo(todo);
    }
  };

  $scope.saveTodo = function(todo) {
    return todo.$save();
  };

  $scope.revertEditing = function (todo) {
    todos[todos.indexOf(todo)] = $scope.originalTodo;
    $scope.doneEditing($scope.originalTodo);
  };

  $scope.removeTodo = function (todo) {
    return todo.$delete().then(function() {
      todos.splice(todos.indexOf(todo), 1);
    }, function(err) {
      console.error(err);
    });
  };

  $scope.clearCompletedTodos = function () {
    angular.forEach(todos, function(todo) {
      if (todo.Completed) {
        $scope.removeTodo(todo);
      }
    });
    $scope.todos = todos = todos.filter(function (val) {
      return !val.Completed;
    });
  };

  $scope.markAll = function (completed) {
    todos.forEach(function (todo) {
      todo.Completed = !completed;
      $scope.saveTodo(todo);
    });
  };
});
