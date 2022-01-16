// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration
module.exports = {
  content: [
    "./js/**/*.js",
    "../lib/*_web.ex",
    "../lib/*_web/**/*.*ex",
    "../lib/*_web/**/*.*heex",
  ],
  theme: {
    extend: {
      colors: {
        primary: "#635994",
        "primary-50": "#6359947d",
      },
    },
  },
  plugins: [require("@tailwindcss/forms")],
};
