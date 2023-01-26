import {
	Entity,
	ObjectIdColumn,
	Column,
	BaseEntity,
	ManyToMany,
	JoinTable,
} from 'typeorm';
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
	displayname: string;

	@ManyToMany(() => User, (user) => user.followers)
	@JoinTable()
	following: User[];

	@ManyToMany(() => User, (user) => user.following)
	followers: User[];

	@Column()
	token: string;
}

export default User;
