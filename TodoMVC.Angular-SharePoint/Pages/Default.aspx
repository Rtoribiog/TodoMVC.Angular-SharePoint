<%@ Page %>
<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<!DOCTYPE html>
<html lang="en" data-framework="angularjs">
    <head>
        <meta charset="utf-8">
        <title> Angular-SharePoint • TodoMVC </title>
        <link rel="stylesheet" type="text/css" href="../Scripts/components/todomvc-common/base.css" />
        <style>[ng-cloak] { display: none; }</style>
    </head>
    <body ng-app="todomvc">
        <form method="post" runat="server" style="display: none">
            <SharePoint:FormDigest runat="server"/>
        </form>
        <ng-view />

        <script type="text/ng-template" id="todomvc-index.html">
            <section id="todoapp" ng-controller="TodoCtrl">
                <header id="header">
                    <h1>todos</h1>
                    <form id="todo-form" ng-submit="addTodo()">
                        <input id="new-todo" placeholder="What needs to be done?" ng-model="newTodo.Title" autofocus>
                    </form>
                </header>
                <section id="main" ng-show="todos.length" ng-cloak>
                    <input id="toggle-all" type="checkbox" ng-model="allChecked" ng-click="markAll(allChecked)">
                    <label for="toggle-all">Mark all as complete</label>
                    <ul id="todo-list">
                        <li ng-repeat="todo in todos | filter:statusFilter track by $index" ng-class="{completed: todo.Completed, editing: todo == editedTodo}">
                            <div class="view">
                                <input class="toggle" type="checkbox" ng-model="todo.Completed" ng-change="saveTodo(todo)">
                                <label ng-dblclick="editTodo(todo)">{{todo.Title}}</label>
                                <button class="destroy" ng-click="removeTodo(todo)"></button>
                            </div>
                            <form ng-submit="doneEditing(todo)">
                                <input class="edit" ng-trim="false" ng-model="todo.Title" todo-escape="revertEditing(todo)" ng-blur="doneEditing(todo)" todo-focus="todo == editedTodo">
                            </form>
                        </li>
                    </ul>
                </section>
                <footer id="footer" ng-show="todos.length" ng-cloak>
                    <span id="todo-count"><strong>{{remainingCount}}</strong>
                        <ng-pluralize count="remainingCount" when="{ one: 'item left', other: 'items left' }"></ng-pluralize>
                    </span>
                    <ul id="filters">
                        <li>
                            <a ng-class="{selected: status == ''} " href="#/">All</a>
                        </li>
                        <li>
                            <a ng-class="{selected: status == 'active'}" href="#/active">Active</a>
                        </li>
                        <li>
                            <a ng-class="{selected: status == 'completed'}" href="#/completed">Completed</a>
                        </li>
                    </ul>
                    <button id="clear-completed" ng-click="clearCompletedTodos()" ng-show="completedCount">Clear completed ({{completedCount}})</button>
                </footer>
            </section>
            <footer id="info">
                <p>Double-click to edit a todo</p>
                <p>Angular-Sharepoint by:
                    <a href="http://github.com/kmees">Kevin Mees</a>
                </p>
                <p>Credits:
                    <a href="http://twitter.com/cburgdorf">Christoph Burgdorf</a>,
                    <a href="http://ericbidelman.com">Eric Bidelman</a>,
                    <a href="http://jacobmumm.com">Jacob Mumm</a> and
                    <a href="http://igorminar.com">Igor Minar</a>
                </p>
            </footer>
        </script>

        <script type="text/javascript" src="../Scripts/components/todomvc-common/base.js"></script>
        <script type="text/javascript" src="../Scripts/components/ShareCoffee/dist/ShareCoffee.js"></script>
        <script type="text/javascript" src="../Scripts/components/angular/angular.js"></script>
        <script type="text/javascript" src="../Scripts/components/angular-route/angular-route.js"></script>
        <script type="text/javascript" src="../Scripts/components/angular-sharepoint/angular-sharepoint.js"></script>

        <script type="text/javascript" src="../Scripts/app/app.js"></script>
        <script type="text/javascript" src="../Scripts/app/controllers/TodoCtrl.js"></script>
        <script type="text/javascript" src="../Scripts/app/services/todoStorage.js"></script>
        <script type="text/javascript" src="../Scripts/app/lists/Todo.js"></script>
        <script type="text/javascript" src="../Scripts/app/directives/todoEscape.js"></script>
        <script type="text/javascript" src="../Scripts/app/directives/todoFocus.js"></script>
    </body>
</html>
