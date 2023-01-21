import { DataSource } from 'typeorm';
import User from './models/user';
import Post from './models/post';
import * as dotenv from 'dotenv';
dotenv.config();

const db = new DataSource({
	type: 'mongodb',
	host: process.env.MONGODB_HOST,
	port: 27017,
	username: process.env.MONGODB_USER,
	password: process.env.MONGODB_PASSWORD,
	database: process.env.MONGODB_DB,
	entities: [User, Post],
	ssl: true,
	authSource: 'admin',
});

export default db;
