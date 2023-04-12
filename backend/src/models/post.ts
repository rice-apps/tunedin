import {
	Entity,
	ObjectIdColumn,
	Column,
	BaseEntity,
	ManyToMany,
	JoinTable,
} from 'typeorm';
import mongodb from 'mongodb';
import User from './user';

@Entity()
class Post extends BaseEntity {
	@ObjectIdColumn()
	id: typeof mongodb.ObjectId;

	@Column()
	author: User;

	@Column()
	bodyText: string;

	@Column()
	musicURL: string;

	@Column()
	createdAt: Date;

	@Column()
	likedBy: mongodb.ObjectId[];

	@Column()
	comments: mongodb.ObjectId[];
}

export default Post;
