$(function  () {
  if(!/test/.test(window.location.pathname))
    $('body').scrollspy()
  $('.show-code').on('click', function  () {
    $(this).closest('.row').children('.example').slideToggle()
  })
  $('ol.default').sortable()
})
;
