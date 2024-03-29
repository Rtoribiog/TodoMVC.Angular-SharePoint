/**
 * The main TodoMVC app module
 *
 * @type {angular.Module}
 */
angular.module('todomvc', ['ExpertsInside.SharePoint', 'ngRoute'])
  .config(function ($routeProvider) {
    'use strict';

    $routeProvider.when('/', {
      controller: 'TodoCtrl',
      templateUrl: 'todomvc-index.html'
    }).when('/:status', {
      controller: 'TodoCtrl',
      templateUrl: 'todomvc-index.html'
    }).otherwise({
      redirectTo: '/'
    });
  });
