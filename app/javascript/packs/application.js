import "bootstrap";
import '../components/message';
import "../plugins/flatpickr"

$('.banner-carousel').carousel({
interval: 3000
})

 $('.carousel').carousel({
  interval: 3000
 })
import { initUpdateNavbarOnScroll } from '../components/navbar';
initUpdateNavbarOnScroll();
