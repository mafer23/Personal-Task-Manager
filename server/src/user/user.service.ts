import { Injectable, InternalServerErrorException, NotFoundException } from '@nestjs/common';
import {PrismaService  } from "../../prisma/prisma.service";
import { CreateUserDto } from './dto/create-user.dto';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UserService {
  constructor(private prisma: PrismaService) {}

  async createUser(body: CreateUserDto) {
    try {
      const salts = await bcrypt.genSalt();
      const hashedPassword = await bcrypt.hash(body.password, salts);
      const user = await this.prisma.user.create({
        data: {
          email: body.email,
          username: body.username,
          password: hashedPassword
        }
      });
      const { password, ...result } = user;
      return result;
    } catch (error) {
      throw new InternalServerErrorException(error.message);
    }
  }

  async findOneUser(username: string) {
    try {
      const user = await this.prisma.user.findFirst({
        where: { username: username }
      });
      if(user) return user;
      return null;
    } catch (error) {
      throw new InternalServerErrorException('Error finding user');
    }
  }

  async getUserById(id: number) {
    console.log('Buscando usuario con id:', id);
    try {
      console.log('Buscando usuario con id:', id);
      const user = await this.prisma.user.findFirst({ where: { id } });
      if (!user)
        throw new NotFoundException(`Usuario con id ${id} no encontrado`);
      const {password, ...result} = user;
      return result;
    } catch (error) {
      if (error instanceof NotFoundException)
        throw new NotFoundException(error.message);
      if (error instanceof Error)
        throw new InternalServerErrorException(error.message);
    }
  }
}
