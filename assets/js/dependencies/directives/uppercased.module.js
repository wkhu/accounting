angular.module("ExApp").directive('uppercased', [function () {
    return {
        require: 'ngModel',
        link: function (scope, elem, attrs, control) {
        	console.log(scope,elem,attrs,control,'directive');
            control.$parsers.push(function(input) {
            	console.log(input,'input directive');
                return input ? input.toUpperCase() : "";
            });
            elem.css("text-transform","uppercase");
        }
    };
}]);