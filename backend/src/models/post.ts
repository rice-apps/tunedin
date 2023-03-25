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
	numLikes: number;

	@Column()
	bodyText: string;

	@Column()
	musicURL: string;

	@ManyToMany(() => User)
	@JoinTable()
	likedBy: User[];
}

export default Post;
