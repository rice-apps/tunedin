import { DataSource } from 'typeorm';
import User from './models/user';

const db = new DataSource({
	type: 'mongodb',
	host: '127.0.0.1',
	port: 27017,
	// username: 'test',
	// password: 'test',
	database: 'test',
	entities: [User],
});

export default db;
