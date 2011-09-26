//= require prototype
//= require prototype_ujs
//= require_self
//= require_tree .

var currentPage = 0;

function checkScroll() {
  if (nearBottomOfPage()) {
    currentPage++;
    $('loading').show();
    new Ajax.Request('/rides.js?page=' + currentPage, {asynchronous:true, evalScripts:true, method:'get'});
  } else {
    setTimeout("checkScroll()", 250);
  }
}

function nearBottomOfPage() {
  return scrollDistanceFromBottom() < 150;
}

function scrollDistanceFromBottom() {
  return pageHeight() - (window.pageYOffset + self.innerHeight);
}

function pageHeight() {
  return Math.max(document.body.scrollHeight, document.body.offsetHeight);
}

document.observe('dom:loaded', checkScroll);