using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Transport
{
    public class Validator
    {
        Regex letters = new Regex("^[a-zA-Z\\s]+$");
        Regex numbers = new Regex("^[0-9]+$");
        Regex passPattern = new Regex(@"^(?=.*[a-zA-Z])(?=.*\d).+$");


        public bool BusNumCheck(string busnum)
        {
            if (busnum.Length == 3 && NumbersCheck(busnum) && busnum != null)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public bool PasswordCheck(string password) 
        {
            if (passPattern.IsMatch(password)  && password.Length >= 8 )
            {
                return true;

            }
            else
            {
                return false;
            }
            
        }

        public bool LettersCheck(string str)
        {
            bool result = letters.IsMatch(str);
            return result;
        }

        public bool NumbersCheck(string num)
        {
            bool result = numbers.IsMatch(num);
            return result;
        }

        public bool TramNumCheck(string tramnum)
        {
            if (tramnum.Length == 4 && tramnum[0] == 'T' && tramnum != null)
            {
                return true;
            }
            else
            {
                return false;
            }
        }




    }
}
