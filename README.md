# svg-to-components-script
A simple bash script that takes `.svg` files from a given directory and creates `.jsx` or `.tsx` components.

## The problem
Unlike create-react-app, Next.js does not come with SVGR. Once you install SVGR you have to configue it with the other technologies you might be using (in my case Typescript and Storybook). I just want my SVGs as `.jsx` or `.tsx` components without the hassle of configuring SVGR.

## The solution
When you run it, the script will create a `SVGs` directory. It will ask for the full path of the folder where you have saved your `.svg` files. It will then ask if you are using Typescript. The next step is deciding if you want your components to be saved and exported as different files or from a singular file. Finally, based on your answers it will create components using your SVGs and you can import them where needed.

## ⚠️Disclaimers
- The script only works for `.svg` files that are saved at the root level of the directory given to the script.
- Dashes in the names of your `.svg` files will be removed so that the component's name will be in `PascalCase`. Underscores are not removed.
