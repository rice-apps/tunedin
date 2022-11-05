import { Entity, ObjectIdColumn, ObjectID, Column, BaseEntity } from 'typeorm';
import db from '../db';

@Entity()
class User extends BaseEntity {
	@ObjectIdColumn()
	id: typeof ObjectID;

	@Column({unique:true})
	username: string;

	@Column()
	name: string;
}

export default User;
