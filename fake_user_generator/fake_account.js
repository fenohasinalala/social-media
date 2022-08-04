import { faker } from '@faker-js/faker';
import fs from 'fs';

function generateUsers() {
    let insert = "INSERT INTO account(first_name, last_name, nickname, birthday, gender, email, profile_pic) VALUES \n";
    let nombre = 500000;

    for (let id = 1; id <= nombre; id++) {
        let x = Math.round(Math.random() * 1 + 1);
        let sex = x == 2 ? 'female' : 'male';
        let firstName = faker.name.firstName(sex).replace("'", "''");
        let lastName = faker.name.lastName(sex).replace("'", "''");
        let nickname = faker.internet.userName(firstName, lastName);
        let rawbirthday = faker.date.birthdate({ min: 14, max: 65, mode: 'age' });
        let birthday = `${rawbirthday.getFullYear()}-${rawbirthday.getMonth() < 9 ? "0" + (rawbirthday.getMonth() + 1) : (rawbirthday.getMonth() + 1)}-${rawbirthday.getDate() < 9 ? "0" + (rawbirthday.getDate()) : (rawbirthday.getDate())}`;
        let gender = sex == 'female' ? 'F' : 'M';
        let email = faker.internet.email(nickname+Math.round(Math.random() * 90000),Math.round(Math.random() * 900));

        if (id == nombre) {
            insert = insert.concat("(" + "'" + firstName + "'," + "'" + lastName + "'," + "'" + nickname + "'," + "'" + birthday + "'," + "'" + gender + "'," + "'" + email + "'," + "'" + firstName + '.png' + "'" + ");")
        } else {
            insert = insert.concat("(" + "'" + firstName + "'," + "'" + lastName + "'," + "'" + nickname + "'," + "'" + birthday + "'," + "'" + gender + "'," + "'" + email + "'," + "'" + firstName + '.png' + "'" + "),\n")
        }
    }
    return { "data": insert }
}

let dataObj = generateUsers();
//console.log(dataObj);
console.log(dataObj.data);
fs.writeFileSync('fake_user.sql', dataObj.data);