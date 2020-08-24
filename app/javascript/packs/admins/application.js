require('@rails/ujs').start();
require('turbolinks').start();

require('config/bootstrap');
require('jquery-mask-plugin');

$(document).ready(() => {
  const inputs = $('[data-mask]').toArray();

  inputs.forEach((element) => {
    const mask = element.getAttribute('data-mask');
    $(element).mask(mask);
  });
});
