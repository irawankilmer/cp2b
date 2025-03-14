<?php
if (!function_exists('setActive')) {
    function setActive($routes, $class = 'active')
    {
        foreach ((array) $routes as $route) {
            if (request()->routeIs($route)) {
                return $class;
            }
        }
        return '';
    }
}
