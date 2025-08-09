import { Injectable } from '@nestjs/common';
import * as bcrypt from 'bcrypt';
import { JwtService } from '@nestjs/jwt';
import { UserService } from 'src/user/user.service';
import { CreateUserDto } from 'src/user/dto/create-user.dto';
import { ValidateUserDto } from '../user/dto/user-validate.dto';
import { UserEntity } from './user';
import { PayloadEntity } from './payload';

@Injectable()
export class AuthService {
  constructor(
    private readonly userService: UserService,
    private readonly jwtService: JwtService,
  ) {}

  async register(createUserDto: CreateUserDto) {
    const hashedPassword = await bcrypt.hash(createUserDto.password, 10);
    const userToSave = { ...createUserDto, password: hashedPassword };
    return this.userService.createUser(userToSave);
  }

  async validateUser(body: ValidateUserDto) {
    const user = await this.userService.findOneUser(body.username);

    if (!user) return null;

    const matchResult = await bcrypt.compare(body.password, user.password ?? '');

    if (matchResult) {
      const { password, ...result } = user;
      return result;
    }

    return null;
  }

  async login(user: UserEntity) {
    const payload: PayloadEntity = { username: user.username, sub: user.id };
    return {
      access_token: this.jwtService.sign(payload),
    };
  }
}
