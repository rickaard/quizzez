export function handleQuizDetailsClick() {
  const quizDetailButtons = document.querySelectorAll(".quiz-details__btn");

  if (!quizDetailButtons) return;

  quizDetailButtons.forEach((button) => {
    const userMenuDropdown = button.nextElementSibling;

    button.addEventListener("click", (event) =>
      showDropdown(event.target, userMenuDropdown)
    );
  });
}

function showDropdown(btnElement, dropDownElement) {
  dropDownElement.classList.toggle("invisible");

  handleOutsideClick(btnElement, dropDownElement);
}

function handleOutsideClick(menuElement, dropDownElement) {
  document.addEventListener("click", onOutsideClick);

  function onOutsideClick(event) {
    if (menuElement.contains(event.target)) return;
    if (dropDownElement.contains(event.target)) return;

    dropDownElement.classList.add("invisible");
    document.removeEventListener("click", handleOutsideClick);
  }
}
