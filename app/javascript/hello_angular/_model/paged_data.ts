
import { Page } from "./page";

export class PagedData<T> {
  data = new Array<T>();
  page = new Page();
}