import { Entity, ObjectIdColumn, Column, BaseEntity } from 'typeorm';
import mongodb from 'mongodb';
// import { ObjectId } from 'mongodb';
import db from '../db';

@Entity()
class User extends BaseEntity {
	@ObjectIdColumn()
	id: typeof mongodb.ObjectId;

	@Column()
	username: string;

	@Column()
	name: string;
}

export default User;
