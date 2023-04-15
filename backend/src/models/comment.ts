import { Entity, ObjectIdColumn, Column, BaseEntity } from 'typeorm';
import mongodb from 'mongodb';
import User from './user';

@Entity()
class Comment extends BaseEntity {
	@ObjectIdColumn()
	_id: typeof mongodb.ObjectId;

	@Column()
	author: User;

	@Column()
	bodyText: string;

	@Column()
	likedBy: mongodb.ObjectId[];
}

export default Comment;
