$(document).ready(function () {
  $('body').on('click', '.match', function () {
    $(this).find(".details").slideToggle("fast");
  });
});