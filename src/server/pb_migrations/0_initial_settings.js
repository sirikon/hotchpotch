/// <reference path="../pb_data/types.d.ts" />

migrate((app) => {
  let settings = app.settings();

  settings.meta.appName = "Hotchpotch";
  settings.meta.appURL = "http://127.0.0.1:8000"

  app.save(settings);
});
