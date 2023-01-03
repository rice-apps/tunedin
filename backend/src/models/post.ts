import { Entity, ObjectIdColumn, Column, BaseEntity } from 'typeorm';
import mongodb from 'mongodb';
import User from './user';

@Entity()
class Post extends BaseEntity {
	@ObjectIdColumn()
	id: typeof mongodb.ObjectId;

	@Column()
	author: User;

	@Column()
	numLikes: number;

	@Column()
	bodyText: string;

	@Column()
	musicURL: string;
}

export default Post;
