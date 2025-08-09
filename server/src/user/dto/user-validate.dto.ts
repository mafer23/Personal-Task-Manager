import { IsEmail, IsNotEmpty, IsString } from 'class-validator';

export class ValidateUserDto {



  @IsNotEmpty()
  @IsString()
  username: string;

  @IsNotEmpty()
  @IsString()
  password: string;
}
