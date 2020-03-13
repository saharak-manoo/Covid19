export class User {
  id: number;
  email: string;
  first_name: string;
  last_name: string;
  full_name: string;
  phone_number: number;
  password: string;
  encrypted_password: string;
  sign_in_count: number;
  created_at: Date;
  updated_at: Date;
  deleted_at: Date;
  admin: boolean;
  photo_url: string;
  roles: [];

  constructor(id: number, email: string, first_name: string, last_name: string, full_name: string, phone_number: number, password: string, encrypted_password: string, sign_in_count: number, created_at: Date, updated_at: Date, deleted_at: Date, admin: boolean, photo_url: string, roles: []) {
    this.id = id;
    this.email = email;
    this.first_name = first_name;
    this.last_name = last_name;
    this.full_name = full_name;
    this.phone_number = phone_number;
    this.password = password;
    this.encrypted_password = encrypted_password;
    this.sign_in_count = sign_in_count;
    this.created_at = created_at;
    this.updated_at = updated_at;
    this.deleted_at = deleted_at;
    this.admin = admin;
    this.photo_url = photo_url;
    this.roles = roles;
  }
}