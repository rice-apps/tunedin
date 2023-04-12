import { Entity, ObjectIdColumn, Column, BaseEntity } from 'typeorm';
import mongodb from 'mongodb';

@Entity()
class User extends BaseEntity {
	@ObjectIdColumn()
	id: typeof mongodb.ObjectId;

	@Column({ unique: true })
	netid: string;

	@Column()
	handle: string;

	@Column()
	name: string;

	@Column()
	posts: mongodb.ObjectId[];

	@Column()
	followers: mongodb.ObjectId[];

	@Column()
	timeline: mongodb.ObjectId[];
}

export default User;
