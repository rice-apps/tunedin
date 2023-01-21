import { Entity, ObjectIdColumn, Column, BaseEntity } from 'typeorm';
import mongodb from 'mongodb';

@Entity()
class User extends BaseEntity {
	@ObjectIdColumn()
	id: typeof mongodb.ObjectId;

	@Column({ unique: true })
	netid: string;

	@Column()
	username: string;

	@Column()
	name: string;

	@Column()
	token: string;
}

export default User;
