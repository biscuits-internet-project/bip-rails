import { Application } from "@hotwired/stimulus";
import ThemeController from "./controllers/theme_controller";
import AccordionController from "./controllers/ui/accordion_controller";

const application = Application.start();

application.register("ui--accordion", AccordionController);
application.register("theme", ThemeController);
