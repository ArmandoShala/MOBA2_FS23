import {StyleSheet, Text, View} from 'react-native';
import {createStackNavigator} from '@react-navigation/stack';
import {NavigationContainer} from '@react-navigation/native';
import React, { useState } from 'react';
import MainPage from './MainPage/MainPage';
import DetailPage from './DetailPage/DetailPage';

export type RootStackParamList = {
    MainPage: undefined;
    DetailPage: { userInput: string };
};

const Stack = createStackNavigator<RootStackParamList>();

export default function App() {
    return (
        <NavigationContainer>
            <Stack.Navigator initialRouteName="MainPage">
                <Stack.Screen name="MainPage" component={MainPage} />
                <Stack.Screen name="DetailPage" component={DetailPage} />
            </Stack.Navigator>
        </NavigationContainer>
    );

}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#fff',
        alignItems: 'center',
        justifyContent: 'center',
    },
});
