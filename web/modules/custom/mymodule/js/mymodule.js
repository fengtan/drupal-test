(function fn($, Drupal) {
  Drupal.behaviors.myModuleBehavior = {
    attach: function attach(context) {
      $("#edit-button", context).click(function click() {
        $("#header", context).slideToggle();
        return false;
      });
    }
  };
})(jQuery, Drupal);
