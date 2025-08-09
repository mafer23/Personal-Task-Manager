import { Controller, Post, UseGuards, Request, Get } from '@nestjs/common';
import { AuthService } from './auth.service';
import { LocalAuthGuard } from './guards/local-auth.guard';
import { JwtAuthGuard } from './guards/jwt-auth.guard';
import { UserService } from 'src/user/user.service';
import { CreateUserDto } from 'src/user/dto/create-user.dto';

@Controller('auth')
export class AuthController {
  constructor(
    private readonly authService: AuthService,
    private readonly userService: UserService
  ) {}

  @Post('/register')
  async register(@Request() req) {
    const body: CreateUserDto = req.body;
    return this.authService.register(body);
  }

  @UseGuards(LocalAuthGuard)
  @Post('/login')
  async login(@Request() req) {
    console.log('User en request:', req.user);
    return this.authService.login(req.user);
  }

    @UseGuards(JwtAuthGuard)
  @Get('/profile')
  async getProfile(@Request() req) {
    return await this.userService.getUserById(req.user.userId);
  }
}
