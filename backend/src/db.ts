import { DataSource } from 'typeorm';
import User from './models/user';
import Post from './models/post';
import Group from './models/group';

const db = new DataSource({
	type: 'mongodb',
	host: '127.0.0.1',
	port: 27017,
	// username: 'test',
	// password: 'test',
	database: 'test',
	entities: [User, Post, Group],
});

export default db;
