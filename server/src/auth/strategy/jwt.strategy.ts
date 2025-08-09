import { Injectable } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { PayloadEntity } from '../payload';
import { UserService } from 'src/user/user.service';
import { SECRET } from 'constants/jwt-key';

@Injectable()
@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor() {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: SECRET,
    });
  }

   validate(payload: PayloadEntity) {
    return { userId: payload.sub, username: payload.username };
  }
}