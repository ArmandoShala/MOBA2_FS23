import React, {useState} from 'react';
import {View, Text, TextInput, Button, StyleSheet} from 'react-native';
import {StackNavigationProp} from '@react-navigation/stack';
import {RootStackParamList} from '../App';


type MainPageNavigationProp = StackNavigationProp<RootStackParamList, 'MainPage'>;

type Props = {
    navigation: MainPageNavigationProp;
};

export default function MainPage({navigation}: Props) {
    const [text, setText] = useState('');

    return (
        <View style={styles.container}>
            <Text style={styles.title}>Enter Text:</Text>
            <TextInput
                style={styles.input}
                onChangeText={setText}
                value={text}
            />
            <Button
                title="Submit"
                onPress={() => navigation.navigate('DetailPage', {userInput: text})}
            />
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
    },
    title: {
        fontSize: 24,
        marginBottom: 20,
    },
    input: {
        height: 40,
        borderColor: 'gray',
        borderWidth: 1,
        paddingHorizontal: 10,
        width: '80%',
        marginBottom: 20,
    },
});
