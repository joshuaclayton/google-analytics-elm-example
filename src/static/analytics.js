const trackPage = function(url) {
  ga("set", "page", url);
  ga("send", "pageview");
};

const removeUndefinedValues = object => {
  return Object.keys(object).reduce((acc, key) => {
    if (typeof object[key] !== "undefined") {
      acc[key] = object[key];
    }

    return acc;
  }, {});
};

const trackEvent = function(eventCategory, eventAction, eventLabel) {
  const eventObject = {
    hitType: "event",
    eventCategory,
    eventAction,
    eventLabel
  };

  ga("send", removeUndefinedValues(eventObject));
};

window.ga = function() {
  console.log([...arguments]);
};

const bootstrapGoogleAnalytics = function(propertyId) {
  // (function(i, s, o, g, r, a, m) {
  //   i["GoogleAnalyticsObject"] = r;
  //   (i[r] =
  //     i[r] ||
  //     function() {
  //       (i[r].q = i[r].q || []).push(arguments);
  //     }),
  //     (i[r].l = 1 * new Date());
  //   (a = s.createElement(o)), (m = s.getElementsByTagName(o)[0]);
  //   a.async = 1;
  //   a.src = g;
  //   m.parentNode.insertBefore(a, m);
  // })(
  //   window,
  //   document,
  //   "script",
  //   "https://www.google-analytics.com/analytics.js",
  //   "ga"
  // );

  ga("create", propertyId, "auto");
};

export default class Analytics {
  constructor(propertyId) {
    bootstrapGoogleAnalytics(propertyId);
  }

  navigateToPage(url) {
    trackPage(url);
  }

  updateName(newName) {
    trackEvent("user", "updateName", newName);
  }
}
