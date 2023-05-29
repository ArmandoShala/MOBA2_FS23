import { createStackNavigator } from '@react-navigation/stack';
import Parent from './Parent';
import Child from './Child';
import React from "react";
import {NavigationContainer} from "@react-navigation/native";

const Stack = createStackNavigator();

const App = () => {
    return (
        <NavigationContainer>
            <Stack.Navigator>
                <Stack.Screen name="Parent" component={Parent} />
                <Stack.Screen name="Child" component={Child} />
            </Stack.Navigator>
        </NavigationContainer>
    );
};

export default App;
