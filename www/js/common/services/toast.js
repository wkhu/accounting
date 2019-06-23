app.factory("TOAST", [
  "$mdToast", function(toast) {
    return function(message, position) {
      var pos;
      pos = position != null ? position : 'top right';
      return toast.show(toast.simple().content(message).position(pos));
    };
  }
]);

//# sourceMappingURL=toast.js.map
