import { DataSource } from 'typeorm';
import User from './models/user';
import Post from './models/post';
import Group from './models/group';
import Comment from './models/comment';

import {
	MONGODB_HOST,
	MONGODB_USER,
	MONGODB_PASSWORD,
	MONGODB_DB,
} from './config';

const db = new DataSource({
	type: 'mongodb',
	host: MONGODB_HOST,
	port: 27017,
	username: MONGODB_USER,
	password: MONGODB_PASSWORD,
	database: MONGODB_DB,
	entities: [User, Post, Group, Comment],
	synchronize: true,
	ssl: true,
	authSource: 'admin',
});

export default db;
