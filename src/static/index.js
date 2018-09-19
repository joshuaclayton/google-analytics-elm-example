require("./styles/main.scss");
import Analytics from "./analytics";
import App from "../elm/Main";

const fetchMetaData = field => {
  const element = document.querySelector(`meta[name=${field}]`);

  if (element) {
    return element.getAttribute("content");
  }
};

document.addEventListener("DOMContentLoaded", () => {
  const application = App.Elm.Main.init({});
  const analytics = new Analytics(
    fetchMetaData("googleAnalyticsPropertyId") || "fake"
  );

  application.ports.trackAnalytics.subscribe(payload => {
    analytics[payload.action](payload.data);
  });
});
