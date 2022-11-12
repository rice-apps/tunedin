import { Entity, ObjectIdColumn, ObjectID, Column, BaseEntity } from 'typeorm';

@Entity()
class User extends BaseEntity {
	@ObjectIdColumn()
	id: typeof ObjectID;

	@Column()
	username: string;

	@Column()
	name: string;

	@Column()
	token: string;
}

export default User;