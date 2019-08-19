// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

const selectEventType = (that) => {
  const toField = document.getElementById('to-field');
  if (that.value === 'once') {
    return toField.style.display = 'none';
  } else {
    return toField.style.display = 'initial';
  }
};
