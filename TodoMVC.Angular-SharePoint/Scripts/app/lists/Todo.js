/**
 * Services that persists and retrieves TODOs from localStorage
 */
angular.module('todomvc').factory('Todo', function ($spList) {
  'use strict';

  return $spList('Todos', {
    queryDefaults: {
      select: ['Id', 'Title', 'Completed']
    }
  });
});
