import { Entity, ObjectID, ObjectIdColumn, Column, BaseEntity } from 'typeorm';
import mongodb from 'mongodb';
// import { ObjectId } from 'mongodb';
import db from '../db';

@Entity()
class Post extends BaseEntity {
	@ObjectIdColumn()
	id: typeof mongodb.ObjectId;

	@Column()
	netID: string;

	@Column()
	postID: number;

	@Column()
	numLikes: number;

	@Column()
	bodyText: string;

	@Column()
	musicURL: string;
}

export default Post;
