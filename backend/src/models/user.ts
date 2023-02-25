import { Entity, ObjectIdColumn, Column, BaseEntity } from 'typeorm';
import mongodb from 'mongodb';
import Post from '../models/post';

@Entity()
class User extends BaseEntity {
	@ObjectIdColumn()
	id: typeof mongodb.ObjectId;

	@Column()
	username: string;

	@Column()
	name: string;

	@Column()
	savedPosts: mongodb.ObjectId[];
}

export default User;
