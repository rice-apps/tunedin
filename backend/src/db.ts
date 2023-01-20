import { DataSource } from 'typeorm';
import User from './models/user';
import Post from './models/post';

const db = new DataSource({
	type: 'mongodb',
	host: 'ac-zphuik1-shard-00-02.xxzexzm.mongodb.net',
	port: 27017,
	username: 'bjk9',
	password: 'xtH0YOJYhG5Bm9QL',
	database: 'TunedIn',
	entities: [User, Post],
});

export default db;
