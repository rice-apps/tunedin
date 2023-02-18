import { Entity, ObjectIdColumn, Column, BaseEntity } from 'typeorm';
import mongodb from 'mongodb';
import User from './user';

@Entity()
class Comment extends BaseEntity {
	@ObjectIdColumn()
	id: typeof mongodb.ObjectId;

	@Column()
	author: User;

	@Column()
	numLikes: number;

	@Column()
	bodyText: string;

	// @Column()
	// postID: typeof mongodb.ObjectId;

	@Column()
	parentCommentID: typeof mongodb.ObjectId;
}

export default Comment;
