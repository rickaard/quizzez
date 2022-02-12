const userMenuItem = document.querySelector("#user-menu");
const userMenuDropdown = document.querySelector("#user-menu__dropdown");

export function handleMenuClick() {
  if (!userMenuItem && !userMenuDropdown) return;

  userMenuItem.addEventListener("click", () => {
    showDropdown();
  });
}

function showDropdown() {
  userMenuDropdown.classList.toggle("invisible");

  handleOutsideClick();
}

function handleOutsideClick() {
  if (userMenuDropdown.classList.contains("invisible")) {
    return;
  }

  document.addEventListener("click", onOutsideClick);

  function onOutsideClick(event) {
    if (userMenuItem.contains(event.target)) return;
    if (userMenuDropdown.contains(event.target)) return;

    userMenuDropdown.classList.add("invisible");
    document.removeEventListener("click", handleOutsideClick);
  }
}
