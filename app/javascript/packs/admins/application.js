require('@rails/ujs').start();
require('turbolinks').start();

require('config/bootstrap');
require('jquery-mask-plugin');


$(document).ready(function(){
   const inputs = $('[data-mask]').toArray();

   
   inputs.forEach(element => {
       const mask = element.getAttribute('data-mask');
       $(element).mask(mask);
   });
    
});