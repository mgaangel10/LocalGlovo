// Generated by https://quicktype.io

export interface AdministradorResponse {
    id:                    string;
    email:                 string;
    username:              string;
    password:              string;
    name:                  string;
    lastName:              string;
    phoneNumber:           string;
    birthDate:             null;
    fotoUrl:               string;
    accountNonExpired:     boolean;
    accountNonLocked:      boolean;
    credentialsNonExpired: boolean;
    enabled:               boolean;
    roles:                 string[];
    createdAt:             null;
    lastPasswordChangeAt:  null;
    puesto:                null;
    authorities:           Authority[];
}

export interface Authority {
    authority: string;
}