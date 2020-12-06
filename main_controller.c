#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <stdlib.h>

// Function Categorizing Scripts to run
void validate_bash();
void ModelSim_libraries();
void ModelSim_setup();
void repo_clone();
void repo_name_scrape();
void uninstall_QMS();
void menu_options();

int main(int argc, char** argv)
{
    static int loop = 1;
    int tty = open("/dev/tty", 2);
    int pid, w;
    int status = 0;

    if (tty == -1)
    {
      fprintf(stderr, "Can't open /dev/tty\n" );
      return -1;
    }

    if ((pid = fork()) == 0)
    {
      close(0); dup(tty);
      close(1); dup(tty);
      close(2); dup(tty);
      close(tty);

      while(loop)
      {
        menu_options();
      }
    }
    printf("Now Exiting QMS...\n");
    close(tty);
    while ((w = wait(&status)) != pid && w != -1);
    if (w == -1) status = -1;
    return status;

}


void menu_options()
{
  int choice;
  printf("<<< QMS script menu >>>\n");
  printf("Please enter the integer besides the script you wish to run\n");
  printf("\n---------------------------------------------------\n");

  printf("1.) Select if first use of QMS or to validate use of QMS.\n");
  printf("2.) ModelSim 32bit libraries installation.\n");
  printf("3.) ModelSim initial setup.\n");
  printf("4.) Clone repositories.\n");
  printf("898.) Uninstall QMS\n");
  printf("0.) To exit QMS program.\n");

  printf("\n---------------------------------------------------\n");

  scanf("%d", &choice);
  switch(choice)
  {
    case 1:
    validate_bash();
    break;
    case 2:
    ModelSim_libraries();
    break;
    case 3:
    ModelSim_setup();
    break;
    case 4:
    repo_clone();
    break;
    case 5:
    repo_name_scrape();
    break;
    case 898:
    uninstall_QMS();
    break;
    case 0:
    exit(1);
    break;
  }
}


void validate_bash()
{
  chdir("QMS_scripts/");
  system("chmod +x *.sh");
  system("./validate_bash.sh");
  chdir("../");
  system("pwd");
}

void ModelSim_libraries()
{
  chdir("QMS_scripts/");
  system("./32bit_libraries.sh");
  chdir("../");
  system("pwd");
}

void ModelSim_setup()
{
  chdir("QMS_scripts/");
  system("./ModelSim_setup.sh");
  chdir("../");
  system("pwd");
}

void repo_clone()
{
  chdir("QMS_scripts/");
  system("./repo_clone_validate.sh");
  chdir("../");
  system("pwd");
}

void repo_name_scrape()
{
  chdir("QMS_scripts/");
  system("./repo_name_scrape.sh");
  chdir("../");
  system("pwd");
}

void uninstall_QMS()
{
  chdir("QMS_scripts/");
  system("./uninstall.sh");
  chdir("../");
  system("pwd");
}
