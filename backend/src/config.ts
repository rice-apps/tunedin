import * as dotenv from 'dotenv';
dotenv.config({ path: '../.env' });

export const MONGODB_HOST = process.env.MONGODB_HOST;
export const MONGODB_USER = process.env.MONGODB_USER;
export const MONGODB_PASSWORD = process.env.MONGODB_PASSWORD;
export const MONGODB_DB = process.env.MONGODB_DB;
export const CLIENT_ID = process.env.CLIENT_ID;
export const CLIENT_SECRET = process.env.CLIENT_SECRET;
export const REDIRECT_URI = process.env.REDIRECT_URI;
export const CAS_SERVICE_URL = process.env.CAS_SERVICE_URL;
export const CAS_SERVICE_URL_ANDROID = process.env.CAS_SERVICE_URL_ANDROID;
export const JWT_SECRET = process.env.JWT_SECRET;
