import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable()
export class RailsService {
  resources: string;

  constructor(private http: HttpClient) { }

  all(path) {
    return this.http.get<any[]>('/' + path);
  }

  get(path) {
    return this.http.get<any[]>('/' + path);
  }

  getDataForPageSide(path, attrs) {
    return this.http.get<any[]>('/' + path, { params: attrs });
  }

  create(path, attrs) {
    return this.http.post<any[]>('/' + path, attrs);
  }

  find(path, id) {
    return this.http.get<any[]>('/' + path + '/' + id);
  }

  update(path, id, attrs) {
    return this.http.put<any[]>('/' + path + '/' + id, attrs);
  }

  delete(path, id) {
    return this.http.delete<any[]>('/' + path + '/' + id);
  }

  signIn(path, attrs) {
    return this.http.post<any[]>('/' + path, attrs);
  }

  signOut(path) {
    return this.http.delete<any[]>('/' + path);
  }
}
